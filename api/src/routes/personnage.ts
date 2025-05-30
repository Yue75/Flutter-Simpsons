import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  const personnages = await prisma.personnage.findMany();
  res.json(personnages);
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  const personnage = await prisma.personnage.findUnique({
    where: { id },
  });
  res.json(personnage);
});

export default router;
