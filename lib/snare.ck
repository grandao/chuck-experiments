class EADSR extends Chubgraph {
    
    inlet => Gain g => outlet;
    Step cte => ADSR e => blackhole;
    1.0 => cte.next;
    0 => g.gain;
    2.0 => float exp;
    
    spork ~ev();
    
    fun void ev() {
        while (true) {
            Math.pow(e.last(), exp) => g.gain;
            1::samp => now;
        }
    }
    
    fun void set(dur a, dur d, float s, dur r) {
        e.set(a, d, s, r);
    }
    
    fun void keyOn() { e.keyOn(); }
    fun void keyOff() {e.keyOff();}
    //fun float last() {return e.last() * e.last();}
    
    fun float E(float f) {f => exp; return exp;}
    fun float E() {return exp;}
}

public class Snare extends Chubgraph {
    TriOsc s => ADSR e;
    Noise n => BPF bpf => Gain g => EADSR en;
    Step cte => ADSR ef => blackhole;
    cte => ADSR efn => blackhole;
    
    80. => float start;
    50. => float end;
    
    100. => float startn;
    100. => float endn;
    
    0.5 => bpf.Q;
    4000 => bpf.freq;
    

    
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
            startn * efn.last() + endn * (1. - efn.last()) => bpf.freq;
            1::samp => now;
        }
    }
    
    
    fun void noise(dur a, dur d, float gain) {
        gain => g.gain;
        en.set(a, d, 0, d);
    }
    
    fun void nfreq(float f0, float f1, dur d) {
        efn.set(0::ms, d, 0, d);
        f0 => startn;
        f1 => endn;
    }
    
    fun void run() {
        e.keyOn();
        ef.keyOn();
        en.keyOn();
        efn.keyOn();
    }
}