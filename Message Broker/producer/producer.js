const express = require('express');
const { Kafka } = require('kafkajs');

const app = express();
app.use(express.json());

const kafka = new Kafka({
    clientId: 'producer-app',
    brokers: ['172.20.17.118:9092'],
});

const producer = kafka.producer();

(async () => {
    await producer.connect();
    console.log('🚀 Producer connected');
})();

app.post('/produce', async (req, res) => {
    const { message } = req.body;

    try {
        await producer.send({
            topic: 'test-topic',
            messages: [{ value: message }],
        });
        res.json({ status: 'Message sent', message });
    } catch (err) {
        console.error('❌ Error sending message:', err);
        res.status(500).json({ error: err.message });
    }
});

app.listen(3000, () => {
    console.log('📡 Kafka Producer API running at http://localhost:3000');
});
