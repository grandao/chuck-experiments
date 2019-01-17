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

public class Hihat extends Chubgraph {
    Noise n => BPF bpf => Gain g => EADSR en;
    
    Step cte => ADSR efn => blackhole;
    1.0 => cte.next;
    
    4000. => float startn;
    3000. => float endn;
    
    0.2 => bpf.Q;
    4000 => bpf.freq;
    
    2.5 => en.E;
    
    en => outlet;
    {

        en.set(0::ms, 10::ms, 0, 10::ms);
        1 => g.gain;
        spork ~_envelope_freq();
    }
    
    
    fun void _envelope_freq() {
        
        while (true) {
            startn * efn.last() + endn * (1. - efn.last()) => bpf.freq;
            1::samp => now;
        }
    }
    
    
    fun void noise(dur a, dur d) {
        en.set(a, d, 0, d);
    }
    
    fun void nfreq(float f0, float f1, dur d) {
        efn.set(0::ms, d, 0, d);
        f0 => startn;
        f1 => endn;
    }
    
    fun void run() {
        en.keyOn();
    }
}