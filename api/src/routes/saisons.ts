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
