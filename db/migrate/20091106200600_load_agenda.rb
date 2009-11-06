class LoadAgenda < ActiveRecord::Migration
  def self.up
    execute("INSERT INTO `agendas` VALUES(1, '08:00', '08:50', 'Credenciamento', NULL, '2009-11-06 19:06:10', '2009-11-06 19:06:10');")
    execute("INSERT INTO `agendas` VALUES(2, '08:50', '09:00', 'Abertura', NULL, '2009-11-06 19:06:32', '2009-11-06 19:06:32');")
    execute("INSERT INTO `agendas` VALUES(3, '09:00', '09:40', 'Palestra I', NULL, '2009-11-06 19:06:47', '2009-11-06 19:37:18');")
    execute("INSERT INTO `agendas` VALUES(4, '09:40', '10:20', 'Palestra II', NULL, '2009-11-06 19:07:04', '2009-11-06 19:38:43');")
    execute("INSERT INTO `agendas` VALUES(5, '10:20', '10:40', 'Coffee-break', NULL, '2009-11-06 19:07:24', '2009-11-06 19:07:24');")
    execute("INSERT INTO `agendas` VALUES(6, '10:40', '11:20', 'Palestra III', NULL, '2009-11-06 19:07:48', '2009-11-06 19:07:48');")
    execute("INSERT INTO `agendas` VALUES(7, '11:20', '12:00', 'Palestra IV', NULL, '2009-11-06 19:08:03', '2009-11-06 19:08:03');")
    execute("INSERT INTO `agendas` VALUES(8, '12:00', '14:00', 'Intervalo par almoço (*)', NULL, '2009-11-06 19:08:23', '2009-11-06 19:08:23');")
    execute("INSERT INTO `agendas` VALUES(9, '14:00', '14:40', 'Palestra V', NULL, '2009-11-06 19:08:38', '2009-11-06 19:08:38');")
    execute("INSERT INTO `agendas` VALUES(10, '14:40', '15:20', 'Palestra VI', NULL, '2009-11-06 19:08:52', '2009-11-06 19:08:52');")
    execute("INSERT INTO `agendas` VALUES(11, '15:20', '15:40', 'Coffee-break', NULL, '2009-11-06 19:19:08', '2009-11-06 19:19:08');")
    execute("INSERT INTO `agendas` VALUES(12, '15:40', '16:20', 'Palestra VII', NULL, '2009-11-06 19:19:24', '2009-11-06 19:19:24');")
    execute("INSERT INTO `agendas` VALUES(13, '16:20', '17:00', 'Palestra VIII', NULL, '2009-11-06 19:19:43', '2009-11-06 19:19:43');")
    execute("INSERT INTO `agendas` VALUES(14, '17:00', '17:40', 'Desconferência ou Palestra IX', NULL, '2009-11-06 19:20:07', '2009-11-06 19:20:07');")
    execute("INSERT INTO `agendas` VALUES(15, '17:40', '18:00', 'Encerramento e sorteios', NULL, '2009-11-06 19:20:28', '2009-11-06 19:20:28');")
    execute("INSERT INTO `agendas` VALUES(16, '18:00', '', '#horaextra', NULL, '2009-11-06 19:20:43', '2009-11-06 19:20:43');")
  end

  def self.down
  end
end
