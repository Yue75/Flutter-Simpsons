import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  const saisons = await prisma.saison.findMany({
    include: {
      episodes: true,
    },
  });
  res.json(saisons);
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  const saison = await prisma.saison.findUnique({
    where: { id },
    include: {
      episodes: true,
    },
  });
  res.json(saison);
});

export default router;

router.post("/", async (req, res) => {
  const { nom } = req.body;

  try {
    const saison = await prisma.saison.create({
      data: {
        titre: nom,
        numero: parseInt(nom.match(/\d+/)[0]),
        slug: nom.toLowerCase().replace(/ /g, "-"),
        image: "assets/saisons/saison-3.webp",
      },
    });

    res.status(201).json(saison);
  } catch (error) {
    res.status(500).json({ error: "Erreur lors de la création de la saison" });
  }
});
