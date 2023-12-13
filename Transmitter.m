clear; clc;

% Read the audio file
[audio, fs] = audioread('audio_file.mp3');

% Convert the audio to 16-bit integers
audio = int16(audio * 32767);

% Convert the audio data to binary
binaryAudio = dec2bin(typecast(audio(:), 'uint16'), 16);

% Password input and hashing using Java Security
password = 'passkey'; % Replace with your desired password
md = java.security.MessageDigest.getInstance('SHA-256');
hash = md.digest(double(password));
hashedPassword = dec2bin(typecast(hash, 'uint8'), 8);

% Reshape hashedPassword to have the same number of columns as binaryAudio
hashedPassword = repmat(hashedPassword(:), ceil(numel(binaryAudio)/numel(hashedPassword)), 1);
hashedPassword = reshape(hashedPassword, size(binaryAudio, 1), []);

% XORing the binary audio data with the hashed password
binaryAudioXORed = char(xor(binaryAudio-'0', hashedPassword(:,1:size(binaryAudio,2))-'0') + '0');

% Read the image
img = imread('demo.png');

% Flatten the image and modified audio
flatImg = img(:);
flatAudio = reshape(binaryAudioXORed, [], 1);

% Hide the audio inside the image
for i = 1:numel(flatAudio)
    if flatAudio(i) == '0'
        flatImg(i) = bitand(flatImg(i), 254); % Set LSB to 0
    else
        flatImg(i) = bitor(flatImg(i), 1);    % Set LSB to 1
    end
end

% Reshape the image back to its original size
modImg = reshape(flatImg, size(img));

% Write the stego image to a file
imwrite(modImg, 'modified.png');

