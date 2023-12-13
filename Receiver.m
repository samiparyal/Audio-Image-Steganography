clear; clc;

% Read the modified image
modImg = imread('modified.png');

% Flatten the Modified (stego) image
flatMOD = modImg(:);

% Extract the LSBs
lsbs = bitget(flatMOD, 1);

% Convert the LSBs to binary
binaryAudio = char(lsbs + '0');

% Prompt for password and hash it using Java Security
password = input('Enter the password: ', 's');
md = java.security.MessageDigest.getInstance('SHA-256');
hash = md.digest(double(password));
hashedPassword = dec2bin(typecast(hash, 'uint8'), 8);

% Reshape hashedPassword to match the dimensions of binaryAudio
hashedPassword = repmat(hashedPassword(:), ceil(numel(binaryAudio)/numel(hashedPassword)), 1);
hashedPassword = reshape(hashedPassword, length(binaryAudio), []);

% XORing the extracted binary audio data with the hashed password
recoveredBinaryAudio = char(xor(binaryAudio-'0', hashedPassword-'0') + '0');

% Convert the binary audio to decimal
audio = typecast(uint16(bin2dec(recoveredBinaryAudio)), 'int16');

% Normalize the audio
audio = double(audio);
audio = audio / max(abs(audio));

% Write the audio to a file
audiowrite('recovered.mp3', audio, 44100);

