# play phrase with velocity and subtle cutoff changes

use_bpm 120 


define :play_phrase do |phrase|
  d = 0.5
  swing = 0.04

  # cutoff accents
  a = rrand(90, 100)
  b = rrand(70, 80)
  c = rrand(85, 95)

  steps = phrase.length
  (0..steps-1).each do |step|
    play phrase[step], amp: [1, 0.2, 0.5, 0.2].tick,
      pan: rrand(-0.15, 0.15),
      release: 0.5, cutoff: ring(a, b, c, b).look
    if(step % 2) == 0
      sleep (d + swing)
    else
      sleep (d - swing)
    end
  end
end


# example
in_thread do
  use_synth :pretty_bell
  loop do
    with_fx :reverb, mix: 0.6 do

      play_phrase [[:e4, :g3, :c3, :a2], :r, :fs4, :e4, [:e4, :e3, :c3, :f1], [:e4, :f3], :d4, [:e4, :gs3], [:e4, :b1], [:e4, :g3], :e4, :r, [:e4, :ab3, :c1], :e4, [:e4, :f2, :f1], [:e4, :as3, :g2, :d1]]

    end
  end
end


in_thread do
  loop do
    sample :bd_haus, amp: 1
    sleep 1
  end
end





