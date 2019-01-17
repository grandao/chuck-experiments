TS ts;
130 => ts.thebeat;
ts.sync();


SawOsc o =>  LPF f => ADSR e => Gain g /*=> NRev d*/ =>  dac;
SinOsc o2 => f;

SinOsc lfo => blackhole;
4. / ts.pulse => lfo.freq;


["F2" /*, "D#2"*/] @=> string notes[];
0 => int i;

fun void modulate(/*string note*/) {
    //note => Utils.ntof => float freq;
    while (true) {
        //(lfo.last() * 0.05 + 1) * freq => o.freq;
        (0.6 + lfo.last() * 0.5) => o.gain;
        1::samp => now;
    }
}


e.set(10::ms, 400::ms, 1, 400::ms);

"F2" => Utils.ntof => o.freq;
0.15 => g.gain;

1000 => f.freq;
0.2 => f.Q;

//0::ms => d.delay;
//50000 => d.max;

"C3" => Utils.ntof => o2.freq;
0.3 => o2.gain;



spork ~modulate(/*"F2"*/);

while(true) {
    e.keyOn();
    (11 * ts.note)::second => now;
    ++i;
    notes[i%notes.cap()] => Utils.ntof => o.freq;
}