/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50635
 Source Host           : localhost:3306
 Source Schema         : multi_language

 Target Server Type    : MySQL
 Target Server Version : 50635
 File Encoding         : 65001

 Date: 04/07/2017 22:48:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for LINGUAGEM
-- ----------------------------
DROP TABLE IF EXISTS `LINGUAGEM`;
CREATE TABLE `LINGUAGEM` (
  `codigo` char(2) NOT NULL,
  `nome` varchar(32) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `codigo` (`codigo`),
  KEY `codigo_2` (`codigo`),
  KEY `codigo_3` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of LINGUAGEM
-- ----------------------------
BEGIN;
INSERT INTO `LINGUAGEM` VALUES ('en', 'Inglês');
INSERT INTO `LINGUAGEM` VALUES ('pt', 'Português');
COMMIT;

-- ----------------------------
-- Table structure for PRODUTOS
-- ----------------------------
DROP TABLE IF EXISTS `PRODUTOS`;
CREATE TABLE `PRODUTOS` (
  `produto_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` int(11) DEFAULT NULL,
  `descricao` int(11) DEFAULT NULL,
  PRIMARY KEY (`produto_id`),
  KEY `fk_produtos_descricao` (`descricao`),
  KEY `fk_produtos_nome` (`nome`),
  CONSTRAINT `fk_produtos_descricao` FOREIGN KEY (`descricao`) REFERENCES `TRADUCAO_REF` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_produtos_nome` FOREIGN KEY (`nome`) REFERENCES `TRADUCAO_REF` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of PRODUTOS
-- ----------------------------
BEGIN;
INSERT INTO `PRODUTOS` VALUES (2, 5, 6);
COMMIT;

-- ----------------------------
-- Table structure for TRADUCAO
-- ----------------------------
DROP TABLE IF EXISTS `TRADUCAO`;
CREATE TABLE `TRADUCAO` (
  `traducao_id` int(11) NOT NULL DEFAULT '0',
  `codigo_linguagem` char(2) NOT NULL DEFAULT '',
  `traducao` text,
  PRIMARY KEY (`traducao_id`,`codigo_linguagem`),
  KEY `fk_traducao_codigo_linguagem` (`codigo_linguagem`),
  CONSTRAINT `fk_traducao_codigo_linguagem` FOREIGN KEY (`codigo_linguagem`) REFERENCES `LINGUAGEM` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_traducao_codigo_traducao_id` FOREIGN KEY (`traducao_id`) REFERENCES `TRADUCAO_REF` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for TRADUCAO_REF
-- ----------------------------
DROP TABLE IF EXISTS `TRADUCAO_REF`;
CREATE TABLE `TRADUCAO_REF` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `id_3` (`id`),
  KEY `id_4` (`id`),
  KEY `id_5` (`id`),
  KEY `id_6` (`id`),
  KEY `id_7` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of TRADUCAO_REF
-- ----------------------------
BEGIN;
INSERT INTO `TRADUCAO_REF` VALUES (5);
INSERT INTO `TRADUCAO_REF` VALUES (6);
COMMIT;

-- ----------------------------
-- Procedure structure for add_produto
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_produto`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_produto`(
	## Variáveis de entrada, neste caso o que vamos inserir na tabela
	IN idioma CHAR(2),
	IN nome VARCHAR(32),
	IN descricao VARCHAR(255)
	)
BEGIN

DECLARE trad_ref_produto_nome int;
DECLARE trad_ref_produto_descricao int;

## Inser 2 registos na tabela TRADUCAO_REF e guarda o id nas variaveis: trad_ref_produto_nome e trad_ref_produto_descricao
INSERT INTO TRADUCAO_REF
SET id = DEFAULT;

SET trad_ref_produto_nome = LAST_INSERT_ID();

INSERT INTO TRADUCAO_REF
SET id = DEFAULT;

SET trad_ref_produto_descricao = LAST_INSERT_ID();

## Inserir Referências na tabela PRODUTOS

INSERT INTO PRODUTOS (nome, descricao)
VALUES(trad_ref_produto_nome, trad_ref_produto_descricao);

## Inserir NA TABELA TRADUCOES
INSERT INTO TRADUCAO VALUES(trad_ref_produto_nome, idioma, nome);
INSERT INTO TRADUCAO VALUES(trad_ref_produto_descricao, idioma, descricao);


END;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
