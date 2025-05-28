import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

/**
 * Fonction pour créer les saisons
 * @returns {Promise<void>}
 */
async function createSaisons() {
  // Création des 3 saisons
  const saisons = [
    { numero: 1, titre: "Saison 1", slug: "saison-1" },
    { numero: 2, titre: "Saison 2", slug: "saison-2" },
    { numero: 3, titre: "Saison 3", slug: "saison-3" },
  ];

  for (const saison of saisons) {
    await prisma.saison.create({
      data: saison,
    });
  }
}

/**
 * Fonction pour créer les personnages principaux
 * @returns {Promise<void>}
 */
async function createPersonnages() {
  const personnages = [
    {
      name: "Homer Simpson",
      slug: "homer-simpson",
      image: "https://example.com/homer.jpg",
      description:
        "Le père de la famille Simpson, employé à la centrale nucléaire de Springfield.",
      cheveux: "Noir",
      genre: "Homme",
      occupation: "Inspecteur de sécurité à la centrale nucléaire",
    },
    {
      name: "Marge Simpson",
      slug: "marge-simpson",
      image: "https://example.com/marge.jpg",
      description: "La mère de la famille Simpson, femme au foyer.",
      cheveux: "Bleu",
      genre: "Femme",
      occupation: "Femme au foyer",
    },
    {
      name: "Bart Simpson",
      slug: "bart-simpson",
      image: "https://example.com/bart.jpg",
      description:
        "Le fils aîné de la famille Simpson, élève à l'école primaire de Springfield.",
      cheveux: "Blond",
      genre: "Homme",
      occupation: "Élève",
    },
    {
      name: "Lisa Simpson",
      slug: "lisa-simpson",
      image: "https://example.com/lisa.jpg",
      description: "La fille de la famille Simpson, élève surdouée.",
      cheveux: "Blond",
      genre: "Femme",
      occupation: "Élève",
    },
    {
      name: "Maggie Simpson",
      slug: "maggie-simpson",
      image: "https://example.com/maggie.jpg",
      description: "La plus jeune de la famille Simpson.",
      cheveux: "Blond",
      genre: "Femme",
      occupation: "Bébé",
    },
  ];

  for (const personnage of personnages) {
    await prisma.personnage.create({
      data: personnage,
    });
  }
}

/**
 * Fonction pour créer les épisodes
 * @returns {Promise<void>}
 */
async function createEpisodes() {
  const saisons = await prisma.saison.findMany();
  const personnages = await prisma.personnage.findMany();

  for (const saison of saisons) {
    for (let i = 1; i <= 10; i++) {
      const episode = await prisma.episode.create({
        data: {
          title: `Épisode ${i} de la saison ${saison.numero}`,
          slug: `episode-${i}-saison-${saison.numero}`,
          description: `Description de l'épisode ${i} de la saison ${saison.numero}`,
          image: `https://example.com/episode-${i}-saison-${saison.numero}.jpg`,
          critique: `Critique de l'épisode ${i} de la saison ${saison.numero}`,
          dateDiffuse: new Date(1990 + saison.numero, i - 1, 1).toISOString(),
          musiques: ["Musique 1", "Musique 2"],
          saisonId: saison.id,
        },
      });

      // Ajouter 5 personnages aléatoires à l'épisode
      const personnagesAleatoires = personnages
        .sort(() => 0.5 - Math.random())
        .slice(0, 5);

      for (const personnage of personnagesAleatoires) {
        await prisma.personnageEpisode.create({
          data: {
            personnageId: personnage.id,
            episodeId: episode.id,
          },
        });
      }
    }
  }
}

/**
 * Fonction principale pour exécuter le seed
 * @returns {Promise<void>}
 */
async function main() {
  try {
    await createSaisons();
    await createPersonnages();
    await createEpisodes();
    console.log("Base de données remplie avec succès !");
  } catch (error) {
    console.error("Erreur lors du remplissage de la base de données:", error);
  } finally {
    await prisma.$disconnect();
  }
}

main();
