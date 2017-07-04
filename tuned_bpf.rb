# tuned bandpass filter

define :play_bpf do |n|
  use_synth :noise
  release_value = rrand(0.01, 0.25)
  n = note(n)
  with_fx :reverb, mix: rrand(0, 0.8), room: rrand(0, 1) do
    with_fx :bpf, centre: n, res: 0.9 do
      play n, amp: 3, pan: rrand(-0.15, 0.15),
        release: release_value
    end
  end
end



# Example
live_loop :test do
  4.times do  
    play_bpf :D5
    sleep 0.25
    play_bpf :F5
    sleep 0.25
    play_bpf :A5
    sleep 0.25
    play_bpf :D6
    sleep 0.125
    play_bpf :F6
    sleep 0.125
    play_bpf :A6
    sleep 0.125
  end 

  4.times do  
    play_bpf :E5
    sleep 0.25
    play_bpf :G5
    sleep 0.25
    play_bpf :B5
    sleep 0.25
    play_bpf :E6
    sleep 0.125
    play_bpf :G6
    sleep 0.125
    play_bpf :B6
    sleep 0.125
  end 
end


