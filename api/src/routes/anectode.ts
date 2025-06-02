import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  const anectodes = await prisma.anectode.findMany();
  res.json(anectodes);
});

export default router;

router.post("/", async (req, res) => {
  try {
    const { anectode } = req.body;

    if (!anectode) {
      return res.status(400).json({ error: "L'anecdote est requise" });
    }

    const newAnectode = await prisma.anectode.create({
      data: {
        anectode,
        date: new Date().toISOString(),
      },
    });

    return res.status(201).json(newAnectode);
  } catch (error) {
    console.error("Erreur lors de la création de l'anecdote:", error);
    return res
      .status(500)
      .json({ error: "Erreur lors de la création de l'anecdote" });
  }
});
