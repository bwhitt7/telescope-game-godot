extends Control

var num_planets = 7

var a_0 = [0.38709927, 0.72333566, 1.52371034, 5.20288700, 9.53667594, 19.18916464, 30.06992276]

var a_i = [0.00000037, 0.00000390, 0.00001847, -0.00011607, -0.00125060, -0.00196176, 0.00026291]

var e_0 = [0.20563593, 0.00677672, 0.09339410, 0.04838624, 0.05386179, 0.04725744, 0.00859048]

var e_i = [0.00001906, -0.00004107, 0.00007882, -0.00013253, -0.00050991, -0.00004397, 0.00005105]

var I_0 = [7.00497902, 3.39467605, 1.84969142, 1.30439695, 2.48599187, 0.77263783, 1.77004347]

var I_i = [-0.00594749, -0.00078890, -0.00813131, -0.00183714, 0.00193609, -0.00242939, 0.00035372]

var L_0 = [252.25032350, 181.97909950, -4.55343205, 34.39644051, 49.95424423, 313.23810451, -55.12002969]

var L_i = [149472.67411175, 58517.81538729, 19140.30268499, 3034.74612775, 1222.49362201, 428.48202785, 218.45945325]

var peri_0 = [77.45779628, 131.60246718, -23.94362959, 14.72847983, 92.59887831, 170.95427630, 44.96476227]

var peri_i = [0.16047689, 0.00268329, 0.44441088, 0.21252668, -0.41897216, 0.40805281, -0.32241464]

var node_0 = [48.33076593, 76.67984255, 49.55953891, 100.47390909, 113.66242448, 74.01692503, 131.78422574]

var node_i = [-0.12534081, -0.27769418, -0.29257343, 0.20469106, -0.28867794, 0.04240589, -0.00508664]

#init
func _ready():
	calc()

#called every frame
func _process(delta):
	pass

func calc():
	
	var t_eph = get_jd()
	var t = (t_eph - 2451545)/36525
	
	var a = []
	var e = []
	var I = []
	var L = []
	var peri = []
	var node = []
	
	for n in num_planets:
		a.append(a_0[n] + a_i[n]*t)
		e.append(e_0[n] + e_i[n]*t)
		I.append(I_0[n] + I_i[n]*t)
		L.append(L_0[n] + L_i[n]*t)
		peri.append(peri_0[n] + peri_i[n]*t)
		node.append(node_0[n] + node_i[n]*t)
	
	var w = []
	var M = []
	var E = []
	var x_prime = []
	var y_prime = []
	
	for n in num_planets:
		w.append(peri[n] - node[n])
		var M_work = L[n] - peri[n] + t^2 + cos(t) + sin(t)
		M.append(M_work % 180)
		
		E.append(get_anomoly(e[n], M[n]))
		
		x_prime.append(a[n]*(cos(E[n])-e[n]))
		y_prime.append(a[n] * sqrt(1-e[n]^2)*sin(E[n]))
		
		

func get_jd():
	var date = Time.get_datetime_dict_from_system(true)
	print(date)
	
	var utc = date["hour"] + date["minute"]/60 + date["second"]/3600
	
	var jd = 367 * date["year"] - int(7*(date["year"] + int((date["month"] + 9)/12))/4) - int(3*(int((date["year"]+(date["month"]-9)/7)/100)+1)/4) + int(275*date["month"]/9) + date["day"] + 1721028.5 + utc/24

func get_anomoly(e, M):
	var e_star = 57.29578*e
	var E = []
	var E_delta = 99999
	var n = 0
	
	E.append(M - e_star * sin(M))
	
	while abs(E_delta) > 0.000001:
		var M_delta = M - (E[n] - e_star*sin(E[n]))
		E_delta = M_delta/(1 - e * cos(E[n]))
		E.append(E[n] + E_delta)
		n = n + 1
		
	return E[n-1]
	
