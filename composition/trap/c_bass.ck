TS ts;
4 => ts.perbar;
120 => ts.thebeat;
ts.sync();


SawOsc o0 => LPF lpf => ADSR e => Chorus ch => NRev r=> dac;
SinOsc o1 => lpf;

0.00 => r.mix;
0.3 => ch.mix;

0.9 => o0.gain;
0.1 => o1.gain;

100 => lpf.freq;
0.5 => lpf.Q;

// set a, d, s, and r
e.set( 10::ms, 20::ms, .5, 400::ms );
// set gain
//2 => o0.gain;

//["C4", "D2", "F4", "G4", "A4"]

["D2", "F2", "A1", "C2"] @=> string notes[];
[2.5, 1.5, 2.5, 1.5] @=>float dt[];


fun void sequencer(string seq[], float dt[], float beat) {
    0 => int i;
    while (true) {
        i % seq.cap() => int idx;
        seq[idx] => Utils.ntof => float f;
        f => o0.freq;
        f * 1.5 => o1.freq;
        
        
        e.keyOn();
        (dt[idx] * beat)::second => now;
        ++i;
    }
}

sequencer(notes, dt, ts.note);