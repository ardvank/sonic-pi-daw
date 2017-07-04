# text staff input

use_bpm 90


ph1 = [
  "4  .e .  .f#.e   .e .e .d .e   .e .e .e .    .e .e .e .e  ",
  "3  .g .  .  .    .e .f .  .g#  .  .  .  .    .ab.  .  .a# ",
  "3  .c .  .  .    .c .  .  .    .  .g .  .    .  .  .  .   ",
  "2  .a .  .  .    .  .  .  .    .  .  .  .    .  .  .f .g  ",
  "1  .  .  .  .    .f .  .  .    .b .  .  .    .c .  .f .d  "
]

ph2 = [
  "4  .  .  .d#.c   .b .b .b .b   .a .a .a .    .  .  .  .   ",
  "3  .f#.  .  .    .e .f .  .g#  .  .  .  .    .ab.  .  .a# ",
  "3  .  .  .  .    .c .  .  .    .  .g .  .    .  .  .  .   ",
  "2  .a .  .  .    .  .  .a .    .  .  .  .    .  .  .f .g  ",
  "1  .  .  .d .    .f .  .  .    .b .  .  .    .c .  .f .d  "
]



define :text_to_tracks do |text_arr|

  tracks_arr = []
  text_arr.each do |str|

    octave = str[0]          # store the octave
    str[0] = ''              # remove octave
    str = str.delete(' ')    # remove all spaces
    str = str.gsub('#', 's') # sharp
    str.concat('.')          # add dummy dot

    # add octaves and rests
    str = str.gsub('.', octave + '.')
    str = str.gsub('.' + octave + '.', '.r.')
    str = str.gsub('.' + octave + '.', '.r.')
    str = str[2..-1]

    # turn into array with strings
    str = str.gsub('.', ',')
    temp_arr = str.split(',')
    # convert strings to symbols
    symbols_arr = []
    temp_arr.each do |s|
      symbols_arr.push(s.to_sym)
    end
    tracks_arr << symbols_arr

  end
  # convert to a playable sonic pi array
  return tracks_to_arr tracks_arr
end


# helper function for function :text_to_tracks
define :tracks_to_arr do |sp_staff_array|

  steps = sp_staff_array[0].length 
  tracks = sp_staff_array.length

  return_array = []
  (0..steps-1).each do |step|
    chord_array = []
    note_count = 0
    rest_count = 0
    (0..tracks-1).each do |track|
      element = sp_staff_array[track][step]
      if element != :r
        note_count += 1
        chord_array << element
      end
    end

    if note_count > 1 # chord
      return_array << chord_array
    elsif note_count == 1
      return_array << chord_array[0]
    else
      return_array << :r
    end

  end
  # copy from log for use in a new composition
  puts return_array
  return return_array
end


# concat phrases function 
def concat_arrays(*arg_array)
  return_arr = []
  arg_array.each do |arg|
    arg.each do |element|
      return_arr << element
    end
  end
  return return_arr
end


# play function
define :play_phrase do |phrase|
  d = 0.25
  swing = 0.04

  steps = phrase.length
  (0..steps-1).each do |step|
    play phrase[step], amp: [1, 0.2, 0.5, 0.2].tick
    if(step % 2) == 0
      sleep (d + swing)
    else
      sleep (d - swing)
    end
  end
end


# conversion of text staffs to sonic pi arrays
phrase1 = text_to_tracks ph1
phrase2 = text_to_tracks ph2

# concat phrases into a verse
verse1 = concat_arrays phrase1, phrase2, phrase2, phrase1 


# play
in_thread do
  use_synth :piano
  4.times do
    play_phrase verse1
    play_phrase phrase1
  end
end


