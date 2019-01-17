TS ts;
130 => ts.thebeat;
ts.sync();


TriOsc o => ADSR e => BPF f => Gain g => NRev r => dac;

0.2 => g.gain;

"C4" => Utils.ntof => o.freq;

e.set(10::ms, 200::ms, 0, 200::ms);

1000 => f.freq;
0.1 => f.Q;

0.1 => r.mix;


["C4", "D#4", "G4", "G#4"] @=> string notes[];



fun void sequencer(string seq[], float beat) {
    0 => int i;
    0 => int fix;
    while (true) {
        notes[Std.rand2(0,3)] => Utils.ntof => o.freq;
        e.keyOn();
        
        //0.95 => float prob;
        //if (fix % 2 == 0) 0.5 => prob;
        0.5 => float prob;
            
        if (Std.randf() > prob) { (beat*0.5)::second => now;}
        else beat::second => now;
        ++i;
    }
}

sequencer(notes, ts.half);


