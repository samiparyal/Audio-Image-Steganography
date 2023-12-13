clear; clc;

% Segment duration for spectrogram analysis (in seconds)
segmentDuration = 5; % Adjust as needed

% Read and convert the original audio to mono
[originalAudio, fs] = audioread('audio_file.mp3');
originalAudio = toMono(originalAudio);

% Read and convert the recovered audio to mono
[recoveredAudio, ~] = audioread('recovered.mp3');
recoveredAudio = toMono(recoveredAudio);

% Read and convert the denoised audio to mono
[denoisedAudio, ~] = audioread('processed_recovered.mp3');
denoisedAudio = toMono(denoisedAudio);

% Create a figure for combined spectrogram comparison
figure;

% Plot the spectrogram segment for Original Audio
plotSpectrogramSegment(originalAudio, fs, 'Spectrogram of Original Audio', segmentDuration, 1);

% Plot the spectrogram segment for Recovered Audio
plotSpectrogramSegment(recoveredAudio, fs, 'Spectrogram of Recovered Audio', segmentDuration, 2);

% Plot the spectrogram segment for Denoised Audio
plotSpectrogramSegment(denoisedAudio, fs, 'Spectrogram of Denoised Audio', segmentDuration, 3);

% Function to convert audio to mono if it's stereo
function monoAudio = toMono(audio)
    if size(audio, 2) == 2
        monoAudio = mean(audio, 2); % Averaging both channels
    else
        monoAudio = audio;
    end
end

% Function for plotting the spectrogram of a segment
function plotSpectrogramSegment(audio, fs, titleText, segmentDuration, subplotIndex)
    segmentLength = round(segmentDuration * fs);
    segmentAudio = audio(1:segmentLength);
    subplot(3,1,subplotIndex);
    spectrogram(segmentAudio, 256, 250, 256, fs, 'yaxis');
    title(titleText);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
end
