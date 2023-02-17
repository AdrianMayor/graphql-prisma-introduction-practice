-- CreateTable
CREATE TABLE `Users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `role` ENUM('ADMIN', 'NORMAL') NOT NULL DEFAULT 'NORMAL',
    `registrationCode` INTEGER NULL,
    `active` BOOLEAN NOT NULL DEFAULT false,
    `activeCode` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `karma` INTEGER NULL,
    `ranking` INTEGER NULL,

    UNIQUE INDEX `Users_id_key`(`id`),
    UNIQUE INDEX `Users_registrationCode_key`(`registrationCode`),
    UNIQUE INDEX `Users_activeCode_key`(`activeCode`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Socials` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `logo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Socials_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SocialsOwned` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idUser` INTEGER NOT NULL,
    `idSocial` INTEGER NOT NULL,

    UNIQUE INDEX `SocialsOwned_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idTicket` INTEGER NOT NULL,
    `idUser` INTEGER NOT NULL,
    `text` VARCHAR(191) NOT NULL,
    `CreatedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Comments_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Tickets` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `openerUserId` INTEGER NOT NULL,
    `reportedUserId` INTEGER NOT NULL,
    `idSocial` INTEGER NOT NULL,
    `nestedTo` VARCHAR(191) NOT NULL,
    `category` ENUM('Harassment', 'Bullying', 'FraudScam', 'BackseatSpoiler', 'FakeRumor', 'TauntProvocation') NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Tickets_id_key`(`id`),
    UNIQUE INDEX `Tickets_openerUserId_key`(`openerUserId`),
    UNIQUE INDEX `Tickets_reportedUserId_key`(`reportedUserId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TagsInTickets` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idTag` INTEGER NOT NULL,
    `idTicket` INTEGER NOT NULL,

    UNIQUE INDEX `TagsInTickets_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Tags` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tagName` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Tags_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Photos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idTicket` INTEGER NOT NULL,
    `picName` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Photos_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `metaPhoto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idPhoto` INTEGER NOT NULL,
    `device` VARCHAR(191) NULL,
    `location` VARCHAR(191) NULL,
    `copyright` VARCHAR(191) NULL,
    `creator` VARCHAR(191) NULL,
    `isEdited` VARCHAR(191) NULL,
    `photoCreationDate` VARCHAR(191) NULL,
    `keywords` JSON NULL,
    `OS` VARCHAR(191) NULL,
    `OsVersion` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `metaPhoto_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `commentVotes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idComment` INTEGER NOT NULL,
    `idUser` INTEGER NOT NULL,
    `vote` BOOLEAN NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `commentVotes_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ticketVotes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `idTicket` INTEGER NOT NULL,
    `idUser` INTEGER NOT NULL,
    `vote` BOOLEAN NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `ticketVotes_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SocialsOwned` ADD CONSTRAINT `SocialsOwned_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SocialsOwned` ADD CONSTRAINT `SocialsOwned_idSocial_fkey` FOREIGN KEY (`idSocial`) REFERENCES `Socials`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comments` ADD CONSTRAINT `Comments_idTicket_fkey` FOREIGN KEY (`idTicket`) REFERENCES `Tickets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comments` ADD CONSTRAINT `Comments_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Tickets` ADD CONSTRAINT `Tickets_openerUserId_fkey` FOREIGN KEY (`openerUserId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Tickets` ADD CONSTRAINT `Tickets_reportedUserId_fkey` FOREIGN KEY (`reportedUserId`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Tickets` ADD CONSTRAINT `Tickets_idSocial_fkey` FOREIGN KEY (`idSocial`) REFERENCES `Socials`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TagsInTickets` ADD CONSTRAINT `TagsInTickets_idTag_fkey` FOREIGN KEY (`idTag`) REFERENCES `Tags`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TagsInTickets` ADD CONSTRAINT `TagsInTickets_idTicket_fkey` FOREIGN KEY (`idTicket`) REFERENCES `Tickets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Photos` ADD CONSTRAINT `Photos_idTicket_fkey` FOREIGN KEY (`idTicket`) REFERENCES `Tickets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `metaPhoto` ADD CONSTRAINT `metaPhoto_idPhoto_fkey` FOREIGN KEY (`idPhoto`) REFERENCES `Photos`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commentVotes` ADD CONSTRAINT `commentVotes_idComment_fkey` FOREIGN KEY (`idComment`) REFERENCES `Comments`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commentVotes` ADD CONSTRAINT `commentVotes_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ticketVotes` ADD CONSTRAINT `ticketVotes_idTicket_fkey` FOREIGN KEY (`idTicket`) REFERENCES `Tickets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ticketVotes` ADD CONSTRAINT `ticketVotes_idUser_fkey` FOREIGN KEY (`idUser`) REFERENCES `Users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
