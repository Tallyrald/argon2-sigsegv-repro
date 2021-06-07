import argon2 from 'argon2';


const doHash = async () => {
    const hashLength = 50;
    const memoryCost = 65536;
    const timeCost = 8;
    const parallelism = 2;
    const type = argon2.argon2id;

    const hash = await argon2.hash('testPassword', {
        hashLength,
        memoryCost,
        parallelism,
        timeCost,
        type,
    });

    console.log(hash);

    const isVerified = await argon2.verify(hash, 'testPassword');

    console.log(isVerified);
}

doHash();
