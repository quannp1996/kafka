const express = require('express');
const { Kafka } = require('kafkajs');

const app = express();
const kafka = new Kafka({
    clientId: 'consumer-app',
    brokers: ['172.20.17.118:9092'],
});

const consumer = kafka.consumer({ groupId: 'test-group' });

(async () => {
    await consumer.connect();
    await consumer.subscribe({ topic: 'test-topic', fromBeginning: true });

    await consumer.run({
        eachMessage: async ({ topic, partition, message }) => {
            console.log(`📥 Message received: ${message.value.toString()}`);
        },
    });

    console.log('🎧 Consumer is listening...');
})();

app.get('/health', (req, res) => {
    res.json({ status: 'Kafka consumer is running' });
});

app.listen(3001, () => {
    console.log('📡 Kafka Consumer API running at http://localhost:3001');
});
