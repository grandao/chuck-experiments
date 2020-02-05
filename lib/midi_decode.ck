

8 => int NOTE_OFF;
9 => int NOTE_ON;
10 => int PKEY_PRESSURE;
11 => int CONTROL_CHANGE;
12 => int PROGRAM_CHANGE;
13 => int CH_PRESSURE;
14 => int PITCH_BEND;
15 => int SYSTEM_COMMON_MESSAGE;

class Decoded {
    0 => int cmd;
    0 => int channel;
    
    0 => int key;
    0 => int value;
    
    fun void decode(MidiMsg m) {
        (m.data1 >> 4)  => cmd;
        (m.data1 & 0xF) => channel;
        m.data2 => key;
        m.data3 => value;
        <<< m.data1 >>>;
    }
    
    fun void print() {
        if (cmd == 8) {
            <<< "NOTE_OFF:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 9) {
            <<< "NOTE_ON:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 10) {
            <<< "PKEY_PRESSURE:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 11) {
            <<< "CONTROL_CHANGE:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 12) {
            <<< "PROGRAM_CHANGE:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 13) {
            <<< "CH_PRESSURE:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 14) {
            <<< "PITCH_BEND:" + channel + " -> " + key + ":" + value >>>;
        } else if (cmd == 15) {
            <<< "SYSTEM_COMMON_MESSAGE:" + channel + " -> " + key + ":" + value >>>;
        }
    }
}

fun int listen() {
    MidiIn min;
    min.open(0) => int result;
    if (!result) {
        <<< "Failed to open device!" >>>;
        return result;
    }
    
    while (true) {
        min => now;
        MidiMsg msg;
        while (min.recv(msg)) {
            Decoded d;
            d.decode(msg);
            d.print();
        }
    }
}


//listen();

