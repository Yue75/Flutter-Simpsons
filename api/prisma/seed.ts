import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

/**
 * Fonction principale qui met à jour les images des épisodes
 */
async function main() {
  try {
    // Récupère tous les épisodes
    const episodes = await prisma.episode.findMany();

    // Met à jour chaque épisode avec la nouvelle URL d'image
    for (const episode of episodes) {
      await prisma.episode.update({
        where: { id: episode.id },
        data: {
          image: "https://www.simpsonspark.com/images/guide/s1/7g08.jpg",
        },
      });
    }

    console.log("Mise à jour des images des épisodes terminée avec succès");
  } catch (error) {
    console.error("Erreur lors de la mise à jour des images:", error);
  } finally {
    await prisma.$disconnect();
  }
}

main();
