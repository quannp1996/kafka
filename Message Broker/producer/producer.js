const { Kafka } = require("kafkajs");

async function runProducer() {
    const kafka = new Kafka({
        clientId: "my-producer",
        brokers: ["kafka:9092"],
    });

    const producer = kafka.producer();
    await producer.connect();

    await producer.send({
        topic: "test-topic",
        messages: [
            { value: "Hello from producer!" },
        ],
    });

    console.log("Message sent!");
    await producer.disconnect();
}

runProducer().catch(console.error);
