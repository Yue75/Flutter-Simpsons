import { PrismaClient } from "@prisma/client";

/**
 * Singleton pattern pour le client Prisma
 * Cette classe assure qu'une seule instance de PrismaClient est créée
 */
class PrismaSingleton {
  private static instance: PrismaClient;

  /**
   * Récupère l'instance unique de PrismaClient
   * @returns {PrismaClient} L'instance unique de PrismaClient
   */
  public static getInstance(): PrismaClient {
    if (!PrismaSingleton.instance) {
      PrismaSingleton.instance = new PrismaClient();
    }
    return PrismaSingleton.instance;
  }
}

// Export de l'instance unique de PrismaClient
export const prisma = PrismaSingleton.getInstance();
