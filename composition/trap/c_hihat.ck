TS ts;
4 => ts.perbar;
120 => ts.thebeat;
ts.sync();

//[0, 1, 1, 1, 0, 1, 1, 1] @=> int seq[];;
[1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0] @=> int seq[];
Hihat h => Gain g => dac;

0.1 => g.gain;

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
//(ts.note * 0.0)::second => now;
sequencer(seq, ts.quarter );