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

router.post("/", async (req, res) => {
  const { title, saisonId } = req.body;

  const slug = title.toLowerCase().replace(/\s+/g, "-");

  try {
    const episode = await prisma.episode.create({
      data: {
        title,
        slug,
        saisonId,
        description: "Description par défaut",
        image: "image-par-defaut.jpg",
        critique: "Critique par défaut",
        dateDiffuse: new Date().toISOString(),
        musiques: [],
      },
    });
    res.status(201).json(episode);
  } catch (error) {
    res.status(400).json({ error: "Erreur lors de la création de l'épisode" });
  }
});

export default router;
