import express from "express";
import Redis from "ioredis";

const app = express();
const port = process.env.PORT || 3000;
const redisUrl = process.env.REDIS_URL || "redis://localhost:6379";
const redis = new Redis(redisUrl);

app.get("/health", async (_req, res) => {
  try {
    await redis.ping();
    res.json({ status: "ok" });
  } catch (e) {
    res.status(500).json({ status: "redis_error", error: String(e) });
  }
});

app.get("/incr", async (_req, res) => {
  const n = await redis.incr("counter");
  res.json({ counter: n });
});

app.listen(port, () => console.log(`app listening on :${port}`));
