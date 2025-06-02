import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  const anectodes = await prisma.anectode.findMany();
  res.json(anectodes);
});

export default router;
