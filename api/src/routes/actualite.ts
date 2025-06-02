import { Prisma } from "@prisma/client";
import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  try {
    const actualites = await prisma.actualite.findMany({
      include: {
        user: {
          select: {
            id: true,
            email: true,
          },
        },
      },
    });
    res.json(actualites);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la récupération des actualités" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const actualite = await prisma.actualite.findUnique({
      where: { id },
      include: {
        user: {
          select: {
            id: true,
            email: true,
          },
        },
      },
    });

    if (!actualite) {
      return res.status(404).json({ error: "Actualité non trouvée" });
    }

    res.json(actualite);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la récupération de l'actualité" });
  }
});

router.post("/", async (req, res) => {
  try {
    const { message, userId } = req.body;

    if (!message || !userId) {
      return res.status(400).json({
        error: "Le message et l'ID de l'utilisateur sont requis",
      });
    }

    const user = await prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      return res.status(404).json({ error: "Utilisateur non trouvé" });
    }

    const actualite = await prisma.actualite.create({
      data: {
        message,
        userId,
      },
      include: {
        user: {
          select: {
            id: true,
            email: true,
          },
        },
      },
    });

    res.status(201).json(actualite);
  } catch (error) {
    console.error("Erreur lors de la création de l'actualité:", error);

    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      return res.status(400).json({
        error: "Erreur de base de données",
        details: error.message,
      });
    }

    res.status(500).json({
      error: "Erreur lors de la création de l'actualité",
      details: error instanceof Error ? error.message : "Erreur inconnue",
    });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { message } = req.body;

    if (!message) {
      return res.status(400).json({ error: "Message est requis" });
    }

    const actualite = await prisma.actualite.update({
      where: { id },
      data: { message },
      include: {
        user: {
          select: {
            id: true,
            email: true,
          },
        },
      },
    });

    res.json(actualite);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la mise à jour de l'actualité" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    await prisma.actualite.delete({
      where: { id },
    });

    res.status(204).send();
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la suppression de l'actualité" });
  }
});

export default router;
