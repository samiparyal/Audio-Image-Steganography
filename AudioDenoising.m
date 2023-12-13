clear; clc;

% Read the recovered audio
[recoveredAudio, fs] = audioread('recovered.mp3');

% Apply a bandpass filter
lowerBound = 300;
upperBound = 3400;
filteredAudio = bandpass(recoveredAudio, [lowerBound, upperBound], fs);

% Normalize the audio
normalizedAudio = filteredAudio - min(filteredAudio(:));
normalizedAudio = normalizedAudio / max(normalizedAudio(:));

% Write the processed audio to a file
audiowrite('processed_recovered.mp3', normalizedAudio, fs);
