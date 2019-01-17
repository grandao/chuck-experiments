public class Kick extends Chubgraph {
    SinOsc s => ADSR e;
    Noise n => Gain g => ADSR en;
    Step cte => ADSR ef => blackhole;
    
    80. => float start;
    50. => float end;
    0. => g.gain;
    
    e => outlet;
    en => outlet;
    {
        1.0 => cte.next;

        ef.set(0::ms, 100::ms, 0, 100::ms);
        e.set(1::ms, 200::ms, 0, 200::ms);
        en.set(0::ms, 10::ms, 0, 10::ms);
        0.1 => g.gain;

        190 => float start;
        50 => float end;
        50 => s.freq;
        spork ~_envelope_freq();
    }
    
    fun void envelope(dur a, dur d, float s, dur r) {
        e.set(a, d, s, r);
    }
    
    fun void efreq(float f0, float f1, dur decay) {
        f0 => start;
        f1 => end;
        ef.set(0::ms, decay, 0, decay);
    }
    
    
    fun void _envelope_freq() {
        
        while (true) {
            start * ef.last() + end * (1. - ef.last()) => s.freq;
            1::samp => now;
        }
    }
    
    fun void noise(dur a, dur d, float gain) {
        gain => g.gain;
        en.set(a, d, 0, d);
    }
    
    fun void run() {
        e.keyOn();
        ef.keyOn();
        en.keyOn();
    }
}


//Kick k => dac;

//while (true) {
//    k.run();
//    (60. / 120.)::second => now;
//}





