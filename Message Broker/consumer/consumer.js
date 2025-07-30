const { Kafka } = require("kafkajs");

async function runConsumer() {
    const kafka = new Kafka({
        clientId: "my-consumer",
        brokers: ["kafka:9092"]
    });

    const consumer = kafka.consumer({ groupId: "test-group" });

    let connected = false;
    while (!connected) {
        try {
            await consumer.connect();
            connected = true;
        } catch (err) {
            console.log("Kafka not ready yet, retrying in 3s...");
            await new Promise((r) => setTimeout(r, 3000));
        }
    }

    await consumer.subscribe({ topic: "test-topic", fromBeginning: true });

    await consumer.run({
        eachMessage: async ({ message }) => {
            console.log(`Received: ${message.value.toString()}`);
        },
    });
}

runConsumer().catch(console.error);
