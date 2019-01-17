TS ts;
120 => ts.thebeat;
ts.sync();


SawOsc o => ADSR e => LPF f => Gain g => Chorus c => NRev r => dac;

0.1 => g.gain;
0.2 => c.mix;
5 => c.modFreq;


e.set(10::ms, 400::ms, 0, 400::ms);

3000 => f.freq;
0.35 => f.Q;

0.1 => r.mix;


["C4", "D4", "F4", "G4", "A4"] @=> string notes[];



fun void sequencer(string seq[], float beat) {
    0 => int i;
    0 => int fix;
    while (true) {
        notes[Std.rand2(0,3)] => Utils.ntof => o.freq;
        e.keyOn();
        
        //0.95 => float prob;
        //if (fix % 2 == 0) 0.5 => prob;
        0.8 => float prob;
        if (Std.randf() > prob) 2 * o.freq() => o.freq;
            
        beat::second => now;
        ++i;
    }
}

sequencer(notes, ts.half);