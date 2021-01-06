
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <rtmidi_c.h>
#include <midiutil.h>

static RtMidiInPtr midi_in = NULL;
static RtMidiOutPtr midi_out = NULL;
static int number_of_intervals = 0;
static int intervals[1024];

static void handle_midi_message(double timestamp, const unsigned char *message, size_t message_size, void *user_data)
{
	switch (rtmidi_message_get_type(message))
	{
		case RTMIDI_MESSAGE_TYPE_NOTE_ON:
		case RTMIDI_MESSAGE_TYPE_NOTE_OFF:
		case RTMIDI_MESSAGE_TYPE_KEY_PRESSURE:
		{
			int interval_number;
			unsigned char new_message[3];
			memcpy(new_message, message, 3);

			for (interval_number = 0; interval_number < number_of_intervals; interval_number++)
			{
				int new_note = rtmidi_note_on_message_get_note(message) + intervals[interval_number];

				if ((new_note >= 0) && (new_note < 128))
				{
					rtmidi_note_on_message_set_note(new_message, new_note);
					rtmidi_out_send_message(midi_out, new_message, 3);
				}
			}

			break;
		}
		default:
		{
			rtmidi_out_send_message(midi_out, message, message_size);
			break;
		}
	}
}

static void usage(char *program_name)
{
	fprintf(stderr, "Usage:  %s --in <port> --out <port> [ <interval> ] ...\n", program_name);
	exit(1);
}

int main(int argc, char **argv)
{
	int i;

	for (i = 1; i < argc; i++)
	{
		if (strcmp(argv[i], "--help") == 0)
		{
			usage(argv[0]);
		}
		else if (strcmp(argv[i], "--in") == 0)
		{
			if (++i == argc) usage(argv[0]);

			if ((midi_in = rtmidi_open_in_port("fakesustain", argv[i], "in", handle_midi_message, NULL)) == NULL)
			{
				fprintf(stderr, "Error:  Cannot open MIDI input port \"%s\".\n", argv[i]);
				exit(1);
			}
		}
		else if (strcmp(argv[i], "--out") == 0)
		{
			if (++i == argc) usage(argv[0]);

			if ((midi_out = rtmidi_open_out_port("fakesustain", argv[i], "out")) == NULL)
			{
				fprintf(stderr, "Error:  Cannot open MIDI output port \"%s\".\n", argv[i]);
				exit(1);
			}
		}
		else
		{
			intervals[number_of_intervals++] = atoi(argv[i]);
		}
	}

	if ((midi_in == NULL) || (midi_out == NULL)) usage(argv[0]);
	MidiUtil_waitForInterrupt();
	rtmidi_close_port(midi_in);
	rtmidi_close_port(midi_out);
	return 0;
}

