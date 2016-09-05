#!/bin/bash

# RPiCCTV - CCTV System for Raspberry Pi
# Copyright (C) 2016 Jason Birch
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see &lt;http://www.gnu.org/licenses/>.

#/**********************************************************************/
#/* V1.00   2016-09-02  Jason Birch                                    */
#/*                                                                    */
#/* Start collecting CCTV image media files. Periodically check that   */
#/* Disk space is not running out, if it is remove some of the oldest  */
#/* CCTV media image files to free disk space.                         */
#/**********************************************************************/

nohup ./Photo.sh &

while [ 1 -eq 1 ]
do
   sleep 3600

	export DataUsed=`df -k /DATA/ | awk '++Count == 2 { print int($5) }'`
	while [ $DataUsed -gt 90 ]
	do
		rm `ls -1t /DATA/*.jpg | tail -1`
		export DataUsed=`df -k /DATA/ | awk '++Count == 2 { print int($5) }'`
	done

	df -k /
	df -k /DATA

	ls -1t /DATA/*.jpg | tail -1
	ls -1t /DATA/*.jpg | head -1
done

