
/*
 * Modified for the ST Microelectronics HTS221 Sensor
 * Copyright (c) 2016 WindRiver, Inc.  All rights reserved.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 *
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#include <linux/input.h>

#define PROC_DEV		"/proc/bus/input/devices"
#define SENSOR_NAME 	"lng2dm"

volatile int interrupt = 0;

// Handle signal interrupt
void sigHandler(int signo) {
	printf("SigINT received.\n");
	interrupt = 1;
}

static char *get_dev_path(void)
{
	static char path[128];
	int i, valid_str = 0;
	char buf[1024];
	FILE *fp;

	printf("Device detection, parsing " PROC_DEV "\n");
	
	if((fp = fopen(PROC_DEV, "r"))) {
		while(fgets(buf, sizeof buf, fp)) {
			switch(buf[0]) {
				case 'N':
					valid_str = strstr(buf, SENSOR_NAME) != 0;
					break;

				case 'H':
					if(valid_str) {
						char *ptr, *start;

						if(!(start = strchr(buf, '='))) {
							continue;
						}
						start++;

						if((ptr = strstr(start, "event"))) {
							start = ptr;
						}

						if((ptr = strchr(start, ' '))) {
							*ptr = 0;
						}
						if((ptr = strchr(start, '\n'))) {
							*ptr = 0;
						}

						snprintf(path, sizeof path, "/dev/input/%s", start);
						printf("Proc subsys says "SENSOR_NAME" sensor is mapped to %s \n", path);
						fclose(fp);
						return path;
					}
					break;

				case '\n':
					valid_str = 0;
					break;

				default:
					break;
			}
		}
	} 
	else {
		perror("Failed to open " PROC_DEV);
	}

	fprintf(stderr, "Trying alternative detection, querying /dev/input/eventX device names...\n");

	/* if for some reason we can't open the /proc/bus/input/devices file, or we
	 * couldn't find our device there, we'll try opening all /dev/input/eventX
	 * devices, and see if anyone is named: 3Dconnexion whatever
	 */
	i = 0;
	for(;;) {
		int fd;

		snprintf(path, sizeof path, "/dev/input/event%d", i++);

		fprintf(stderr, "  Trying \"%s\" ... ", path);

		if((fd = open(path, O_RDONLY)) == -1) {
			if(errno != ENOENT) {
				fprintf(stderr, "Failed to open %s: %s. This might hinder device detection\n",
						path, strerror(errno));
				continue;
			} 
			else {
				fprintf(stderr, "unknown\n");
				close(fd);
				break;
			}
		}

		if(ioctl(fd, EVIOCGNAME(sizeof buf), buf) == -1) {
			fprintf(stderr, "Failed to get device name for device %s: %s. This might hinder device detection\n",
					path, strerror(errno));
			buf[0] = 0;
		}

		fprintf(stderr, "%s\n", buf);

		if(strstr(buf, SENSOR_NAME)) {
			close(fd);
			printf("EVIOCGNAME says "SENSOR_NAME" sensor is mapped to %s \n", path);
			return path;
		}
	}
	return(0);  //should never get here
}

int main()
{
	int fd;
	struct input_event ie;
	int axis_x;
        int axis_y;
        int axis_z; 
	static char *dev_path;

	//catch interrupt signal
	signal(SIGINT, sigHandler);
	signal(SIGTERM, sigHandler);

	dev_path=get_dev_path();
//	printf("Device path is %s \n", dev_path);
	
    if((fd = open(dev_path, O_RDONLY)) == -1) {
		perror("opening "SENSOR_NAME" device");
		exit(EXIT_FAILURE);
	}

	while(!interrupt) {
		if (read(fd, &ie, sizeof(struct input_event)) != 0) {
//			printf("type %d\tcode %d\tvalue %d\n", ie.type, ie.code, ie.value);
			if (ie.type == 4) {
				switch (ie.code){
					case 0:  //axis_x
						axis_x = ie.value;
				 		break;
			 		case 1:   //axis_y
			 			axis_y = ie.value;
				 		break;
					case 2: //axis_z
						axis_z = ie.value;
				 	default:
				 		break;
				}
			}
		}
		else {
			printf("Sensor read failed...aborting\n");
			break;
		}
		
		printf("Accelerometer axis_x = %d, axis_y = %d, axis_z = %d\n", axis_x, axis_y, axis_z);
		
	}
	
	(void) close(fd);
	return 0;
}

