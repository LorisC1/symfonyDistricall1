-- Adminer 4.8.1 MySQL 10.6.15-MariaDB-1:10.6.15+maria~deb11 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `age` int(3) NOT NULL,
  `sex` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = women, 0 = man',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `user` (`id`, `email`, `password`, `age`, `sex`) VALUES
(1,	'test@districall.com',	'$2y$13$YhT/n7cIfCd9ZvBvPwyr7OspHi4xRtTvYgf45anG4T3y2/uLPewwO',	30,	1);

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT '(DC2Type:datetime_immutable)',
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_23A0E66A76ED395` (`user_id`),
  CONSTRAINT `FK_23A0E66A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article` (`id`, `user_id`, `name`, `description`, `content`, `created_at`, `image`) VALUES
(1,	1,	'Lorem ipsum',	'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus faucibus ut tellus id gravida.',	'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus faucibus ut tellus id gravida. Duis sed iaculis justo. Nam vitae libero non mauris blandit sagittis et sit amet augue. Ut interdum felis non erat suscipit, pulvinar congue neque pretium. Praesent commodo dictum erat, sit amet sollicitudin felis congue id. Duis ante orci, facilisis vel nisl tempor, placerat hendrerit neque. Morbi ut finibus augue. Proin ac justo tempor eros tempor porta sed ut justo. Aliquam ipsum augue, ornare vitae accumsan placerat, rhoncus eu nisi. Aenean interdum leo a mauris gravida pulvinar. Vestibulum consectetur, urna volutpat efficitur lacinia, quam justo dictum mi, eget dignissim urna justo at sapien. Nam sollicitudin scelerisque sodales. Vestibulum et nibh dapibus, consequat mauris rhoncus, tincidunt mauris. Vestibulum finibus porttitor tristique.\r\n\r\nSed interdum dictum mi sed tristique. Proin blandit diam ligula, quis cursus justo vulputate rutrum. Cras vestibulum ligula ut convallis viverra. Suspendisse aliquam ex in fermentum finibus. Cras vitae pulvinar urna. Proin dictum erat ut volutpat mattis. Nullam porttitor venenatis purus, quis facilisis diam aliquet ut. Mauris tincidunt tellus odio, sit amet scelerisque justo varius et. Phasellus tellus arcu, dapibus sed nunc quis, imperdiet congue leo. Suspendisse gravida feugiat justo, ut dictum dolor cursus id.\r\n\r\nMauris non sagittis odio. Sed ullamcorper id nisl ac tempus. Duis ac malesuada risus. Cras eleifend, arcu ac vehicula mattis, massa nulla semper est, vel elementum elit justo at urna. Nam lorem turpis, dapibus sit amet pellentesque eget, aliquet nec nulla. Aliquam malesuada arcu quis imperdiet elementum. Donec lobortis ligula ex, et aliquam felis mollis ac. Pellentesque dapibus turpis a quam maximus bibendum.\r\n\r\nMorbi commodo lacus in vestibulum condimentum. Curabitur convallis libero at odio auctor blandit. Nullam laoreet semper vehicula. Pellentesque tincidunt velit tortor, eu efficitur ipsum lobortis eu. Nulla consectetur dictum massa, porta ultrices risus. Nullam fermentum mi a fermentum aliquet. Etiam tellus augue, bibendum non tristique a, blandit sit amet mauris. Donec sit amet aliquet nibh, a tincidunt dui. Ut non nisl enim. Cras ac efficitur quam. Quisque maximus sed risus porttitor imperdiet. Nullam pretium lorem sapien, id pharetra arcu commodo eget. Morbi lacinia nunc magna, in faucibus purus accumsan efficitur. Praesent placerat blandit tempus. Curabitur luctus nisi nulla, vel luctus sapien eleifend sit amet. Cras fringilla lacus quis feugiat venenatis.\r\n\r\nDonec a nibh eget ex lacinia viverra. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque elementum porttitor diam, a placerat dui placerat ac. Donec porttitor tristique odio et cursus. Fusce posuere massa a lacus scelerisque mollis. Etiam nec semper tellus, interdum efficitur augue. Quisque in tempor elit, eu rutrum eros. Proin at scelerisque magna. Nullam sit amet dolor suscipit, tempus turpis ac, consequat mauris. Aliquam ligula magna, tincidunt vel eros eget, commodo tincidunt lacus. Fusce vitae malesuada turpis. Pellentesque consectetur mollis lectus, vitae volutpat nisi laoreet in. Duis in volutpat justo. Proin ut accumsan dui',	'2023-11-14 10:39:03',	NULL);

DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rate` int(2) NOT NULL COMMENT '0 to 10',
  PRIMARY KEY (`id`),
  KEY `IDX_D88926227294869C` (`article_id`),
  KEY `IDX_D8892622A76ED395` (`user_id`),
  CONSTRAINT `FK_D88926227294869C` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `FK_D8892622A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `rating` (`id`, `article_id`, `user_id`, `rate`) VALUES
(1,	1,	1,	7);
