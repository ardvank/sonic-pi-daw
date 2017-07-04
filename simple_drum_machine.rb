# Simple drum machine

use_bpm 120 


# velocity patterns (0-9)
hihat_velo      =  [3, 2, 5, 2,  3, 2, 5, 2,  3, 2, 5, 2,  3, 2, 5, 2 ] 
snare_velo      =  [6, 3, 4, 3,  6, 4, 4, 3,  6, 3, 4, 3,  6, 3, 4, 2 ]
kick_velo       =  [6, 3, 4, 3,  6, 4, 4, 3,  6, 3, 4, 3,  6, 3, 4, 3 ]


# samples
hihat = :drum_cymbal_closed
snare = :elec_mid_snare
kick  = :elec_hollow_kick


# patterns, 0 = rest, 1 = trigger, 2 or more = trigger probability
snare_pattern   =  [ 0, 0, 0, 0,  1, 0, 0, 0,  0, 0, 0, 0,  1, 0, 0, 6 ]
hihat_pattern   =  [ 1, 5, 1, 6,  1, 5, 1, 5,  1, 5, 1, 5,  1, 2, 1, 3 ]
kick_pattern    =  [ 1, 0, 9, 0,  1, 0, 0, 0,  1, 0, 1, 0,  1, 0, 5, 0 ]


define :play_sample_pattern do |samp, sample_pattern, velocity_pattern|
  d = 0.25
  swing_time = 0.04

  sample_pattern.each_with_index do |element, index|
    if one_in(element)
      sample samp, amp: velocity_pattern[index]
    end
    if(index % 2) == 0
      sleep (d + swing_time)
    else
      sleep (d - swing_time)
    end
  end
end


# Play
live_loop :hihat do
  play_sample_pattern hihat, hihat_pattern, hihat_velo
end

live_loop :snare do
  play_sample_pattern snare, snare_pattern, snare_velo
end

live_loop :kick do
  play_sample_pattern kick, kick_pattern, kick_velo
end
