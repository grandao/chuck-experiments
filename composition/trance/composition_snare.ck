TS ts;
130 => ts.thebeat;
ts.sync();


[1, 0, 0, 0, 0, 0, 0, 0] @=> int seq[];
Snare s =>  Gain g => dac;

0.3 => g.gain;

s.envelope(1::ms, 70::ms, 0, 70::ms);
s.efreq(240, 180, 30::ms);
s.noise(1::ms, 400::ms, 0.6);
s.nfreq(4000, 2000, 400::ms);

fun void sequencer(int seq[], float beat) {
    0 => int i;
    while (true) {
        if (seq[i % seq.cap()] != 0)
            s.run();
        beat::second => now;
        ++i;
    }
}

sequencer(seq, ts.quarter);