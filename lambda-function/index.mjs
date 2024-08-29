import fetch from 'node-fetch';

export const handler = async (event) => {
    const API_KEY = process.env.PURPLEAIR_API_KEY;
    const fields = [
            "name",
            "location_type",
            "latitude",
            "longitude",
            "altitude",
            "model",
            "firmware_version",
            "last_seen",
            "pm2.5_10minute"
        ];
    const show_only = [
            190203, 190189, 176181, 176173, 176203, 176155, 190325, 190197, 
            212487, 176179, 176197, 176157, 190195, 212833, 212849, 176231, 
            176149, 212459, 176175, 176185, 190185, 190217, 212455, 190199, 
            176253, 176251, 176177, 176207, 190211, 212855, 176183, 212697,
            158897, 20377, 133015, 154713, 137496, 136696
        ];

    const url = `https://api.purpleair.com/v1/sensors?fields=${fields}&show_only=${show_only}`;

    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'X-API-Key': API_KEY
            }
        });
        const data = await response.json();

        return {
            statusCode: 200,
            body: JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json',
            },
        };
    } catch (error) {
        console.error('Error:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ error: 'Failed to fetch data from PurpleAir API' }),
        };
    }
};