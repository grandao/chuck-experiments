public class Utils {
    //Scales
    ["C2", "D2", "E2", "F2", "G2", "A2", "B2", "C3"] @=> static string diatonic[];
    ["C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3", "C4"] @=> static string chromatic[];
    ["D2", "F2", "G2", "A2", "C3", "D3"] @=> static string minyo[];
    ["D2", "Eb2", "G2", "A2", "Bb2", "D3"] @=> static string miyko[];
    ["C2", "D2", "E2", "G2", "A2", "C3"] @=> static string pentatonic[];
    [ "A1", "C2", "D2", "E2", "G2", "A2"] @=> static string pentatonic2[];
    //Note to midi
    fun static int ntom(string s) {
        21 => int A0;
        
        s.upper() => s;
        0 => int key;
        0 => int octave;
        0 => int dec;
        //A, B, C, D, E, F, G
        [0, 2, -9, -7, -5, -4, -2] @=> int scale[];
        
        if (s.length() > 0) {
            // A
            s.charAt(0) - 65 => key;
            
            if (s.length() > 2) {
                // #
                if (s.charAt(1) == 35) 1 => dec;
                // b
                else if (s.charAt(1) == 66) -1 => dec;
                    
                s.charAt(2) - 48 => octave;
            } else  if (s.length() > 1) {
                s.charAt(1) - 48 => octave;
            }
        }
        
        return A0 + scale[key] + 12 * octave + dec;
    }
    
    fun static float ntof(string s) {
        s => ntom => int midi;
        return Std.mtof(midi);
    }
}





