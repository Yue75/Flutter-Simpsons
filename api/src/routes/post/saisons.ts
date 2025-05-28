import { PrismaClient } from "@prisma/client";
import { Router } from "express";

const router = Router();
const prisma = new PrismaClient();

router.post("/", async (req, res) => {
  res.json({
    message: "Hello World",
  });
});

export default router;
