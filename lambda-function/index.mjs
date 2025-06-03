import fetch from 'node-fetch';

const AIRTABLE_BASE_ID = 'app47BTSMOR7BEbwT';
const AIRTABLE_TABLE_NAME = 'Deployments';  // Adjust to your actual table name
const AIRTABLE_VIEW_NAME = 'Public';    // Adjust to your actual view name
const AIRTABLE_TOKEN = process.env.AIRTABLE_TOKEN;  // Store securely in env

async function getSensorIDsFromAirtable() {
    const params = new URLSearchParams();
    params.append('view', AIRTABLE_VIEW_NAME);
    params.append('fields[]', 'ID');

    const url = `https://api.airtable.com/v0/${AIRTABLE_BASE_ID}/${encodeURIComponent(AIRTABLE_TABLE_NAME)}?${params.toString()}`;
    const response = await fetch(url, {
        headers: {
            Authorization: `Bearer ${AIRTABLE_TOKEN}`
        }
    });

    if (!response.ok) {
        console.error('Failed to fetch Airtable data:', await response.text());
        throw new Error('Failed to fetch Airtable data');
    }

    const data = await response.json();
    return data.records
        .map(record => record.fields['ID'])
        .filter(id => typeof id === 'number');  // Ensure only numeric IDs
}

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

    let show_only;
    try {
        show_only = await getSensorIDsFromAirtable();
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message }),
        };
    }

    const url = `https://api.purpleair.com/v1/sensors?fields=${fields.join(',')}&show_only=${show_only.join(',')}`;

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
            body: JSON.stringify(data)
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message })
        };
    }
};
