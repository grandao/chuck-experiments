TS ts;
130 => ts.thebeat;
ts.sync();


[0, 0, 1, 0] @=> int seq[];
Hihat h => Gain g => dac;

0.15 => g.gain;

h.noise(1::ms, 60::ms);
h.nfreq(7000, 3000, 30::ms);

fun void sequencer(int seq[], float beat) {
    0 => int i;
    while (true) {
        if (seq[i % seq.cap()] != 0)
            h.run();
        (1 * beat)::second => now;
        ++i;
    }
}

sequencer(seq, ts.quarter);