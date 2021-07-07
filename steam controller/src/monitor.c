/**
 * \file monitor.c
 * \brief Encompasses command for taking controller into and out of state where
 *  	USB UART prints periodic updates of state of controller (i.e. which
 *	buttons are being pressed and data being returned from peripherals).
 *
 * MIT License
 *
 * Copyright (c) 2018 Gregory Gluszek
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "monitor.h"

#include "adc_read.h"
#include "buttons.h"
#include "trackpad.h"
#include "usb.h"
#include "time.h"

#include <stdio.h>

/**
 * Print command usage details to console.
 *
 * \return None.
 */
void monitorCmdUsage(void) {
	printf(
		"usage: monitor\n"
		"\n"
		"Enter a loop giving updates on all controller inputs.\n"
		"Press any key to exit loop.\n"
	);
}

/**
 * Handle Monitor command line function.
 *
 * \param argc Number of arguments (i.e. size of argv)
 * \param argv Command line entry broken into array argument strings.
 *
 * \return 0 on success.
 */
int monitorCmdFnc(int argc, const char* argv[]) {

	//while (!usb_tstc()) {
		//usb_flush();

		//usleep(100 * 1000);

		updateAdcVals();
		trackpadLocUpdate(L_TRACKPAD);
		trackpadLocUpdate(R_TRACKPAD);

		uint16_t adc_l_trig = getAdcVal(ADC_L_TRIG);
		uint16_t adc_r_trig = getAdcVal(ADC_R_TRIG);
		printf(" %d", adc_l_trig);
		printf(" %d", adc_r_trig);
		printf(" %d", getLeftTriggerState());
		printf(" %d", getRightTriggerState());
		printf(" %d", getLeftBumperState());
		printf(" %d", getRightBumperState());

		uint16_t x_loc = 0;
		uint16_t y_loc = 0;

		trackpadGetLastXY(L_TRACKPAD, &x_loc, &y_loc);

		printf(" %d", x_loc);
		printf(" %d", y_loc);

		trackpadGetLastXY(R_TRACKPAD, &x_loc, &y_loc);

		printf(" %d", x_loc);
		printf(" %d", y_loc);

		printf(" %d", getLeftTrackpadClickState());
		printf(" %d", getFrontLeftButtonState());
		printf(" %d", getSteamButtonState());
		printf(" %d", getFrontRightButtonState());
		printf(" %d", getRightTrackpadClickState());


		uint16_t adc_joy_x = getAdcVal(ADC_JOYSTICK_X);
		uint16_t adc_joy_y = getAdcVal(ADC_JOYSTICK_Y);
		printf(" %d", adc_joy_x);
		printf(" %d", adc_joy_y);


		printf(" %d", getJoyClickState());

		printf(" %d", getXButtonState());
		printf(" %d", getYButtonState());
		printf(" %d", getAButtonState());
		printf(" %d", getBButtonState());

		printf(" %d", getLeftGripState());
		printf(" %d", getRightGripState());
		printf(" ");
		printf("¿");
		usb_flush();

		//usleep(20000);
	//}
	//printf("\r");

	return 0;
}
