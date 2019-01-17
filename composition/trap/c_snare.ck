TS ts;
4 => ts.perbar;
120 => ts.thebeat;
ts.sync();


[0, 0, 0, 0, 1, 0, 0, 0] @=> int seq[];
Snare s =>  Gain g => dac;

0.2 => g.gain;

s.envelope(1::ms, 70::ms, 0, 70::ms);
s.efreq(240, 120, 30::ms);
s.noise(1::ms, 350::ms, 0.6);
s.nfreq(4000, 2000, 350::ms);

fun void sequencer(int seq[], float beat) {
    0 => int i;
    while (true) {
        if (seq[i % seq.cap()] != 0)
            s.run();
        (1 * beat)::second => now;
        ++i;
    }
}

//(ts.note * 0.5)::second => now;
sequencer(seq, ts.half);