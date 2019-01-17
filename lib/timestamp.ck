// Time stamp control for sync multiple music compositions

public class TS{

    70 => static float BPM; // Beat per Minute (tempo)
    60/BPM => float pulse; // Converting: beat lapse in seconds

    8 => int perbar; // Beats per bar for sync purpose

    // Define names for the durations:

    // SECONDS:
    perbar*pulse => static float bar;
    pulse => static float note;
    pulse/2 => static float half;
    pulse/4 => static float quarter;
    pulse/8 => static float eighth;
    pulse/16 => static float sixteenth;

    // DURATIONS:
    pulse::second => dur white;
    half::second => dur minim;
    quarter::second => dur crotchet;
    eighth::second => dur quaver;
    sixteenth::second => dur semiquaver;

    // Update note duration when BPM (tempo) changes
    fun void thebeat(float newBPM){
      newBPM => BPM;
      60/BPM => pulse;
      perbar*pulse => bar;
      pulse => note;
      pulse/2 => half;
      pulse/4 => quarter;
      pulse/8 => eighth;
      pulse/16 => sixteenth;

      pulse::second => white;
      half::second => minim;
      quarter::second => crotchet;
      eighth::second => quaver;
      sixteenth::second => semiquaver;
    }

    fun void division(int newdiv){
      newdiv => perbar;
      perbar*pulse => bar;
    }
    // Sync module: bar sync
    fun void sync(){
      bar::second - (now % bar::second) => now;
    }

}
