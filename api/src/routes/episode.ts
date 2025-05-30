import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  const episodes = await prisma.episode.findMany();
  res.json(episodes);
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  const episode = await prisma.episode.findUnique({
    where: { id },
  });
  res.json(episode);
});

export default router;
