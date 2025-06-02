import { Prisma } from "@prisma/client";
import { Router } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req, res) => {
  try {
    const users = await prisma.user.findMany({
      select: {
        id: true,
        email: true,
        actualites: {
          select: {
            id: true,
            message: true,
          },
        },
      },
    });
    res.json(users);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la récupération des utilisateurs" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const user = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        email: true,
        actualites: {
          select: {
            id: true,
            message: true,
          },
        },
      },
    });

    if (!user) {
      return res.status(404).json({ error: "Utilisateur non trouvé" });
    }

    res.json(user);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la récupération de l'utilisateur" });
  }
});

router.post("/", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email) {
      return res.status(400).json({
        error: "L'email est requis",
      });
    }

    const user = await prisma.user.create({
      data: {
        email,
        password,
      },
      select: {
        id: true,
        email: true,
      },
    });

    res.status(201).json(user);
  } catch (error) {
    console.error("Erreur lors de la création de l'utilisateur:", error);

    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      return res.status(400).json({
        error: "Erreur de base de données",
        details: error.message,
      });
    }

    res.status(500).json({
      error: "Erreur lors de la création de l'utilisateur",
      details: error instanceof Error ? error.message : "Erreur inconnue",
    });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { email } = req.body;

    if (!email) {
      return res.status(400).json({ error: "L'email est requis" });
    }

    const user = await prisma.user.update({
      where: { id },
      data: { email },
      select: {
        id: true,
        email: true,
      },
    });

    res.json(user);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la mise à jour de l'utilisateur" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    await prisma.user.delete({
      where: { id },
    });

    res.status(204).send();
  } catch (error) {
    res
      .status(500)
      .json({ error: "Erreur lors de la suppression de l'utilisateur" });
  }
});

export default router;
