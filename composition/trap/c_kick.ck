TS ts;
4 => ts.perbar;
120 => ts.thebeat;
ts.sync();


[1, 0, 0, 0, 0, 0, 0, 0,   1, 1, 0, 0, 0, 0, 0, 0] @=> int seq[];
Kick k => Gain g => dac;
0.5 => g.gain;

k.envelope(1::ms, 400::ms, 0, 400::ms);
k.efreq(180, 50, 70::ms);
k.noise(3::ms, 5::ms, 0.005);

fun void sequencer(int seq[], float beat) {
    0 => int i;
    while (true) {
        if (seq[i % seq.cap()] != 0)
            k.run();
        beat::second => now;
        ++i;
    }
}

sequencer(seq, ts.half);