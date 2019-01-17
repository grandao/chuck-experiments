public class Keyboard extends Chubgraph {
    SndBuf wav[87];
    
    fun void load(string path) {
        ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"] @=> string notes[];
        
        for (0 => int i; i < 87; ++i) {
            //start at A0
            (i+9) % 12 => int id;
            (i+9) / 12 => int octave;
            
            path + "/" + notes[id] + Std.itoa(octave) + ".wav" => wav[i].read;
            
            wav[i].samples() - 1 => wav[i].pos;
            wav[i] => outlet;
        }
    }
    
    fun void play(int midi) {
        midi - 21 => int id;
        
        if (id >= 0 && id < 87)
            0 => wav[id].pos;
    }
    
    
    fun void play(int midis[]) {
        for (0 => int i; i < midis.cap(); ++i)
            play(midis[i]);
    }
    
    fun int listen() {
        MidiIn min;
        min.open(0) => int result;
        if (!result)
            return result;
        
        while (true) {
            min => now;
            MidiMsg msg;
            while (min.recv(msg)) {
                //noteon
                if (msg.data1 >= 144 && msg.data1 <= 159 && msg.data3 != 0) {
                    play(msg.data2); //note number
                }
                //msg.data3 velocity
            }
        }
    }
}


/*

Keyboard kb => dac;

kb.load(me.dir() + "marimba");

1::second => now;

<<< "starting" >>>;


for (21 => int i; i < 80; ++i) {
    kb.play(i);
    500::ms => now;
}


while (true) {

for (0 => int i; i < 4; ++i) {
    kb.play([60 - 12, 60, 65, 68]);
    0.5::second => now;
}

for (0 => int i; i < 4; ++i) {
    kb.play([58 - 12, 58, 65, 68]);
    0.5::second => now;
}

for (0 => int i; i < 4; ++i) {
    kb.play([60 - 12, 60, 64, 67]);
    0.5::second => now;
}

for (0 => int i; i < 4; ++i) {
    //F C F G#
    kb.play([41, 60, 65, 68]);
    0.5::second => now;
}
}
/**/