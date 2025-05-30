import { z } from "zod";

/**
 * Schéma de validation pour les données d'un personnage
 * Ce schéma définit la structure et les règles de validation pour les données d'un personnage
 */
export const personnageSchema = z.object({
  id: z.string(),
  name: z.string().min(1, "Le nom est requis"),
  slug: z.string().min(1, "Le slug est requis"),
  image: z.string().url("L'URL de l'image doit être valide"),
  description: z.string().min(1, "La description est requise"),
  cheveux: z.string().min(1, "La couleur des cheveux est requise"),
  genre: z.string().min(1, "Le genre est requis"),
  occupation: z.string().min(1, "L'occupation est requise"),
});

/**
 * Type dérivé du schéma Zod pour les données d'un personnage
 */
export type IPersonnage = z.infer<typeof personnageSchema>;
